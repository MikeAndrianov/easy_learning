module MessagesHelper
 def pretty_date(time)
   date = time.to_date
   date_today = Date.today
   if date == date_today
     date.strftime("%I:%M")
   elsif date == date_today.yesterday
     "yesterday"
   elsif date.year == date_today.year
    date.strftime("%d %b")
   elsif date.year < date_today.year
    date.strftime("%d %b %Y")
   end
 end

 def starting_message(message)
   message.body[0..40] + "..."
 end

 def starting_recipients(message)
   recipients = message.recipients.map {|rec| rec.name }
   recipients.length > 3 ? recipients.slice(0,3).join(" ") : recipients.join(" ")
 end

end
