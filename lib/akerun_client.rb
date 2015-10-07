require 'rest_client'

class AkerunClient
  class <<self
    def method_missing(method_name, *args, &block)
      self.new.execute(method_name, *args, &block)
    end
  end

  def execute(api_name, params={}, &block)
    api = api_config(api_name)
    Rails.logger.error "before execute params: #{params.inspect}"
    params = (api[:defaults] || {}).merge(params).map do |k, v|
      v = v.iso8601 if v.respond_to?(:iso8601)
      [k.to_s, v]
    end.to_h

    url = api[:url]
    params.keys.sort_by(&:length).reverse.each do |k|
      url.gsub!(":#{k}", params.delete(k).to_s) if url.include?(":#{k}")
    end

    if api[:method].downcase == 'get'
      res = RestClient.get(url, params: params, &block)
    elsif api[:method].downcase == 'post'
      res = RestClient.post(url, params, &block)
    elsif api[:method].downcase == 'delete'
      res = RestClient.delete(url, params: params, &block)
    elsif api[:method].downcase == 'put'
      res = RestClient.put(url, params, &block)
    end
    hash_res = HashWithIndifferentAccess.new(JSON.parse(res))
    Rails.logger.info "akerun_client url: #{url} params: #{params.inspect} response: #{hash_res.inspect}"
    hash_res
  end

  private
  def api_config(name)
    api_configs = config_file['api'].map do |k, v|
      v['url'] = "#{config['api_root']}#{v['path']}"
      [k, HashWithIndifferentAccess.new(v)]
    end.to_h
    api_configs[name.to_s]
  end

  @@config = nil
  private
  def config
    @@config ||= config_file[Rails.env]
  end

  @@config_file = nil
  private
  def config_file
    @@config_file ||= YAML.load_file(Rails.root.join('config', 'akerun.yml'))
  end

end
