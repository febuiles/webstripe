require 'simple_xlsx'

class XlsReport
  def self.serialize
    path = "#{Rails.root}/tmp/webstripe.xlsx"
    FileUtils.rm(path) if File.exists?(path)

    serializer = SimpleXlsx::Serializer.new(path) do |doc|
      doc.add_sheet("Users") do |sheet|
        sheet.add_row(%w{ID Username Email Date Type Stripes Status})
        User.all.each do |user|
          sheet.add_row([user.id, user.username, user.email, user.created_at,
                         user.role, user.stripes.count, user.status])
        end
      end
    end
  end
end

