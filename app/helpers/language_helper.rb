module LanguageHelper
  LANGUAGES = {
    "es-co": "Español (Colombia)",
    en: "English",
    fr: "Français",
    "zh-CN": "简体中文"
  }

  def language_options
    LANGUAGES.slice(*I18n.available_locales).invert.to_a
  end
end
