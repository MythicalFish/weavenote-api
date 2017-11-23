module SendgridInbound

  extend ActiveSupport::Concern
  include ActionView::Helpers::TextHelper

  def parse_comment_reply

    envelope = JSON.parse(params['envelope'])
    comment_key = envelope['to'][0].split('@')[0].split('-')[1]
    comment = Comment.where({key: comment_key}).try(:first)
    user = User.find_by_email(envelope['from'])
    divs = Nokogiri.HTML(params['html']).css('div')
    text = simple_format(divs.first.content) if divs.any?
    text = params['text'] unless divs.any?
    
    return nil unless comment && user && text

    return {
      user: user,
      text: text,
      commentable: comment,
      organization: comment.organization
    }

  end

end