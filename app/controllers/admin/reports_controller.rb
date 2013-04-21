class Admin::ReportsController < ApplicationController
  def xls
    XlsReport.serialize
    send_file("#{Rails.root}/tmp/webstripe.xlsx",
              :type =>'application/vnd.ms-excel',
              :disposition => "attachment")
  end
end
