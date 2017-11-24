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
    
    unless comment && user && text
      msg = "\n\n\n\n"
      msg << "<!--- Email parse failed --->"
      msg << "\n\n"
      msg << "Envelope: #{envelope}\n"
      msg << "User: #{user.try(:email)}\n"
      msg << "Comment ID: #{comment.try(:id)}\n"
      msg << "Text: #{text}"
      msg = "\n\n\n\n"
      logger.error msg
      return false
    end

    return {
      user: user,
      text: text,
      commentable: comment,
      organization: comment.organization
    }

  end

end