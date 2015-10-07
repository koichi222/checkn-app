require 'securerandom'

module ArExt
  def self.included(base)
    base.extend ClassMethods

    def base.inherited(child)
      super
      if child != ActiveRecord::SchemaMigration && child.column_names.include?('key')
        child.before_validation :generate_key
        child.validates :key, uniqueness: true, presence: true
      end
    end
  end

  module ClassMethods
  end

  private
  def generate_key
    self.key ||= SecureRandom.urlsafe_base64(32).tr('lIO0', 'sxyz')
  end
end
