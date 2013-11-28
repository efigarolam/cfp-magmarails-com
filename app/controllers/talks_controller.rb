class TalksController < ActionController::Base
  protect_from_forgery
  respond_to :js, :html

  def index
    @propos = Cfp::Proposal.paginate(page: params[:page], per_page: 8)
    respond_with(@props) do |format|
      format.js { @propos }
    end
  end

end