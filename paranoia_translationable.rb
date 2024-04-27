module ParanoiaTranslationable
  extend ActiveSupport::Concern

  class_methods do
    def paranoia_translates(attribute, options = {})
      translates attribute
      begin
        translation_class.send :acts_as_paranoid # necessary because of conflicts between translation gem and paranoia
      rescue StandardError
        nil
      end

      relation_name = options.fetch(:relation_name, "#{name.downcase}_translations")

      define_method(attribute.to_s) do
        if send(:deleted?)
          send(relation_name.to_s)
            .with_deleted
            .where(locale: I18n.locale)
            .order('deleted_at DESC NULLS FIRST')
            .first&.name
        else
          super()
        end
      end
    end
  end
end
