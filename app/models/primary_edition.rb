class PrimaryEdition < Book
  alias_attribute :original_title, :title
  alias_attribute :original_subtitle, :subtitle
  alias_attribute :original_language, :language
end
