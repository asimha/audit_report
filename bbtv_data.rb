require 'sinatra'
require 'rubygems'
require 'roo'
require 'roo-xls'
require 'pry'
require 'eat'
require 'json'


get '/' do
  erb :upload
end


post '/xlsx' do
  tempfile = params[:audit_requirement][:tempfile] 
  filename = params[:audit_requirement][:filename] 
  # cp(tempfile.path, "public/uploads/#{filename}")
  if params[:audit_requirement][:type] == "application/vnd.ms-excel"
    xlsx = Roo::Spreadsheet.open(tempfile)
    xlsx = Roo::Excel.new(tempfile)
  else
    xlsx = Roo::Spreadsheet.open(tempfile)
    xlsx = Roo::Excelx.new(tempfile)
  end

  xlsx.info

  call_sign = xlsx.sheet(0).column(3)
  @call_signs_b = call_sign.compact.uniq

  channel = xlsx.sheet(0).column(2)
  @channel_b = channel.compact.uniq

  http = eat(params['url'])
  call_signs = JSON.parse(http)
  @call_signs_j = call_signs['channels'].collect{|chan| chan['metadata']['call_sign']}
  @channels_j = call_signs['channels'].collect{|chan| chan['metadata']['channel_name']}

  @hash_array = {}
  @xlsx_hash = {}

  @call_signs_j.compact.uniq.each_with_index do |value, index|
    @hash_array[value] = @channels_j.compact.uniq[index]
  end

  @call_signs_b.compact.uniq.each_with_index do |value, index|
    @xlsx_hash[value] = @channel_b.compact.uniq[index]
  end

  call_signs_a = @call_signs_j.compact.uniq - @call_signs_b.compact.uniq
  call_signs_b = @call_signs_b.compact.uniq - @call_signs_j.compact.uniq
  call_signs_b.shift
  @call_signs_a = call_signs_a.sort
  @call_signs_b = call_signs_b.sort

  erb :upload
  # => Returns basic info about the spreadsheet file

end

get '/json' do
  erb :json_data
end

post '/json_data' do
  http = eat(params['url'])
  call_signs = JSON.parse(http)
  @call_signs_j = call_signs['channels'].collect{|chan| chan['metadata']['call_sign']}
  @channels_j = call_signs['channels'].collect{|chan| chan['metadata']['channel_name']}
  @guid_j = call_signs['channels'].collect{|chan| chan['channel_guid']}
  
  @hash_channels = {}
  @hash_guid = {}
  
  @call_signs_j.compact.uniq.each_with_index do |value, index|
    @hash_channels[value] = @channels_j.compact[index]  
    @hash_guid[value] = @guid_j.compact[index]  
  end

  erb :json_data
end

