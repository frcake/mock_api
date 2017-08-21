require 'sinatra'
require 'json'


get '/modems' do
  content_type :json
  @data = {}
  @array = []
  Modems = Struct.new(:modem)
  Modem =  Struct.new(:did,:lat,:lon,:serial_number,:name)
  @modems = Modems.new(
    [
      Modem.new(234,125162,436346,'ASG123','Astipalea').to_h,
      Modem.new(235,546,654,'ASG124','Korinthos').to_h,
      Modem.new(236,743,4578,'ASG125','Whatever').to_h,
      Modem.new(237,743,458,'ASG126','Vessel').to_h,
      Modem.new(238,734,854,'ASG127','Modem').to_h,
      Modem.new(239,845,436346,'ASG128','Hack').to_h
    ]
  )
  @data =  {:data => @modems.modem}
  @data.to_json
end

get '/modem/:did' do |modem_id|
  content_type :json
  @data = {}
  Modems = Struct.new(:info)
  Modem = Struct.new(:did,:timestamp,:ipdown,:ipup,:rtt,:rx_snr,:tx_snr,:txpower,:rxpower,:temp,:time,:offset,:tdmacrc,:dvbs2crc8,:dvbs2crc32)
  @modems = Modems.new([
    Modem.new(234,'11:42',321,532,765,876,987,5464,345,234,546,657,5678,768,698).to_h,
    Modem.new(235,'12:23',321,532,765,876,987,5464,345,234,546,657,5678,768,698).to_h,
    Modem.new(236,'5:34',321,532,765,876,987,5464,345,234,546,657,5678,768,698).to_h,
    Modem.new(237,'1:54',321,532,765,876,987,5464,345,234,546,657,5678,768,698).to_h,
    Modem.new(238,'2:42',321,532,765,876,987,5464,345,234,546,657,5678,768,698).to_h,
    Modem.new(239,'7:43',321,532,765,876,987,5464,345,234,546,657,5678,768,698).to_h,
  ])
  @data = {:data => @modems.info}
  {:data => [ @data.dig(:data).find { |each| each.dig(:did) == modem_id.to_i } ] }.to_json
end

get '/optionfile/:did' do |file_id|
  content_type :json
  @data = {}
  Options = Struct.new(:file)
  Option = Struct.new(:did,:text)
  @options = Options.new([
    Option.new(234,'Lorem Ipsum is simply dummy text of the printing and').to_h,
    Option.new(235,'typesetting industry. Lorem Ipsum has been the industry`s').to_h,
    Option.new(236,'standard dummy text ever since the 1500s, when an unknown').to_h,
    Option.new(237,'printer took a galley of type and scrambled it to make a type').to_h,
    Option.new(238,'specimen book. It has survived not only five centuries, but also').to_h,
    Option.new(239,'the leap into electronic typesetting, remaining essentially').to_h,
  ])
  @data = {:data => @options.file}
  {:data => [ @data.dig(:data).find { |each| each.dig(:did) == file_id.to_i } ] }.to_json
end
