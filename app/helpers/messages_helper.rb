module MessagesHelper
 def pretty_date(time)
   date = time.to_date
   date_today = Date.today
   return result = case date
     when date.year < date_today.year then date.strftime("%d %b %Y")
     when date.year == date_today.year then date.strftime("%d %b")
     when date == date_today.yesterday then "yesterday"
     when date == date_today then date.strftime("%I:%M")
   end
 end
end
