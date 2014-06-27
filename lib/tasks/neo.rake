namespace :neo do
  desc "Migrate old user macros"
  task migrate_user_macros: :environment do
    ids =  WikiContent.pluck(:id)

    OLD_MACRO_STYLE = /macro:user\s(\{[^}]+})/i
    NEW_MACRO_STYLE = "{{user(%s)}}"
    count = 1

    WikiContent.transaction do

      ids.each do |id|
        print "."        if count % 5 == 0
        puts " #{count}" if count % 100 == 0

        content = WikiContent.find(id)
        has_macro = false

        text = content.text.gsub(OLD_MACRO_STYLE) do |match|
          has_macro = true
          json = JSON.parse($1)
          if json["login"].present?
            args = []
            args << json.delete("login")
            json.each { |k, v| args << "#{k}=#{v}" }

            NEW_MACRO_STYLE % args.join(", ")
          else
            match
          end
        end

        if has_macro
          content.text = text
          content.save!
        end

        count += 1
      end

    end
  end
end
