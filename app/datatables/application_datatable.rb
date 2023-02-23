class ApplicationDatatable < ::AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegator :@view, :link_to

  def initialize(params, opts = {})
    @view = opts[:view_context]
    raise "Need pass view_context in opts" unless @view.present?
    super
  end
end
