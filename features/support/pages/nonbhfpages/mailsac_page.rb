class MailsacPage < GenericPage

  def initialize(browser)
    super
    @url = "https://mailsac.com/"
  end

  def trait
    trait = browser.a(text: 'mailsac')
    return trait
  end

  def inbox(address)
    inbox_field = browser.input(class:'myinbox')
    if address.include?('@')
      raise("this doesn't look like a Mailsac address which confuses and bewilders me") unless address.split('@')[1]=="mailsac.com"
      address = address.split('@')[0]
    end
    sendkeys!(inbox_field, address)
    browser.button(text: 'Check the mail!').click!
  end

  def message_count
    msg_count = browser.div(class:'inbox').h3.text
    return msg_count
  end

  def messages
    msg_rows = browser.div(class:'inbox').tbody
    msgs = []
    msg_rows.trs(class: 'clickable').each do |m|
      msgs << m unless m.attribute_value("class")=="ng-hide"
    end
    return msgs
  end

  def msg_by_subject(subject)
    msgs = messages
    matches = []
    msgs.each do |m|
      matches << m unless m.td(class:"col-xs-5").text != subject
    end
    binding.pry
    matches[0].click
    browser.goto(matches[0].a(text: "Unblock links and images ↗").href)
  end

  def f_and_e_content_check
    data = EnvConfig.data['f_n_e_email_content']
    raise("Mailsac buttons not found") unless browser.a(text: 'Sign in to reply').present?
    raise("Mailsac buttons not found") unless browser.a(text: 'Buy private email addresses, send messages, or build with the developer API.')
    raise("Unable to find image") unless browser.img(src: data['img_src']).present?
    data['span'].each do |s|
      raise("Unable to find content: #{s}") unless browser.span(text: s).present?
    end
    data['font'].each do |d|
      raise("Unable to find content: #{d}") unless browser.font(text: d).present?
    end
    check_booking_details(data['booking_details'])
    raise("Unable to find image") unless browser.img(src: data['footer_src']).present?
    raise("Unable to find disclaimer") unless browser.p(class: "disclaimer").text == data['disclaimer']
  end

  def check_booking_details(data)
    details = []
    details << "Reference number: #{@@f_and_e_reference}"
    details << "Number of large items to be collected: #{data['items']}"
    details << "Number of bags to be collected: #{data['bags']}"
    details << "First preferred collection date: #{data['date1']}"
    # details << "First preferred collection date: #{Time.now.strftime("%d/%m/#{Time.now.year+1}"}"
    details << "Second preferred collection date: #{data['date2']}"
    data['what_next'].each do |w|
      details << w
    end
    details.each do |d|
      raise("Unable to find (#{d})") unless browser.p(text: d).present?
    end
    data['before_contact'].each do |b|
      raise("Unable to find (#{b})") unless browser.li(text: b).present?
    end
    binding.pry
  end

end
