import { Controller } from "@hotwired/stimulus"

const STORAGE_KEY = "coreui-rails-starter-theme"
const THEMES = ["light", "dark", "auto"]

export default class extends Controller {
  connect() {
    this.mediaQuery = window.matchMedia("(prefers-color-scheme: dark)")
    this.apply(this.preferredTheme)
    this.mediaQuery.addEventListener("change", this.handleSystemThemeChange)
  }

  disconnect() {
    this.mediaQuery.removeEventListener("change", this.handleSystemThemeChange)
  }

  select(event) {
    const theme = event.currentTarget.dataset.coreuiThemeValue
    if (!THEMES.includes(theme)) return

    localStorage.setItem(STORAGE_KEY, theme)
    this.apply(theme)
  }

  handleSystemThemeChange = () => {
    if (this.preferredTheme === "auto") this.apply("auto")
  }

  get preferredTheme() {
    const storedTheme = localStorage.getItem(STORAGE_KEY)
    return THEMES.includes(storedTheme) ? storedTheme : "auto"
  }

  apply(theme) {
    const resolvedTheme = theme === "auto" ? (this.mediaQuery.matches ? "dark" : "light") : theme
    document.documentElement.setAttribute("data-coreui-theme", resolvedTheme)

    this.element.querySelectorAll("[data-coreui-theme-value]").forEach((button) => {
      const active = button.dataset.coreuiThemeValue === theme
      button.classList.toggle("active", active)
      button.setAttribute("aria-pressed", active)
    })

    const selectedIcon = this.element.querySelector(`[data-coreui-theme-value="${theme}"] use`)
    const activeIcon = this.element.querySelector(".theme-icon-active use")
    if (selectedIcon && activeIcon) activeIcon.setAttribute("xlink:href", selectedIcon.getAttribute("xlink:href"))

    document.documentElement.dispatchEvent(new Event("ColorSchemeChange"))
  }
}
