module MessagesHelper
 def pretty_date(time)
   date = time.to_date
   date_today = Date.today
   case date
     when date.year < date_today.year then date.strftime("%d %b %Y")
     when date.year == date_today.year then date.strftime("%d %b")
     when date == date_today.yesterday then "yesterday"
     when date == date_today then date.strftime("%I:%M")
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
