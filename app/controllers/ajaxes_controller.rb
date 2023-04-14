class AjaxesController < ApplicationController
  def create 
    @ajax = Ajax.new(ajax_params)
    respond_to do |format|
      if @ajax.save
        format.js
      end
    end
  end

  def index
    @ajaxes = Ajax.all
    @ajax = Ajax.new
  end

  private
    def ajax_params
      params.require(:ajax).permit(:content)
    end
end
