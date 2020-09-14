class SearchesController < ApplicationController
  def search
  	search = params[:search]
  	if search.blank?
  		redirect_to request.referer
  	else
  	    @tags = Tag.search(search)
  	end
  end
end
