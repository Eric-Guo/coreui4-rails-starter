module LanguageHelper
  LANGUAGES = {
    "es-co": "Spanish (Columbia)",
    en: "English",
    fr: "French",
    "zh-CN": "Chinese (Simplified)",
  }

  def language_options
    LANGUAGES.slice(*I18n.available_locales).invert.to_a
  end
end
