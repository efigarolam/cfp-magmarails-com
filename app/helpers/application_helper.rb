module ApplicationHelper

  def already_reviewed(proposal)
    if Cfp::Rank.for_proposal_user(proposal, current_user)
      raw "<i class='icon-ok'></i>"
    end
  end


  def next_help(id)
    ids = Cfp::Rank.where(:user_id => current_user.id).map(&:proposal_id) << id
    next_proposal = Cfp::Proposal.where('id NOT IN (?)', ids).first
    link_to(raw("Continue <i class='icon-arrow-right'></i>"), proposal_comments_path(next_proposal.id), class: 'btn btn-orange pull-right' )  if next_proposal
  end

  def counter
    ready = Cfp::Rank.where(:user_id => current_user.id).count
    proposals = Cfp::Proposal.all.count
    raw "<h3 class='total span2 offset5'>#{ready} / #{proposals}</h3>"
  end

  def user_based_proposal_path(proposal)
    current_user.can_review? ? proposal_comments_path(proposal) : proposal_path(proposal)
  end

end
