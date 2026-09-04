export async function loadSelectize() {
  const { default: $ } = await import("jquery")
  window.$ = $
  window.jQuery = $
  await import("@selectize/selectize/dist/js/selectize")
  return $
}
