require 'sinatra'
require 'rubygems'
require 'roo'
require 'pry'
require 'eat'
require 'json'

Choices = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles',
}

get '/' do
  erb :upload
end


post '/xlsx' do
  tempfile = params[:audit_requirement][:tempfile] 
  filename = params[:audit_requirement][:filename] 
  # cp(tempfile.path, "public/uploads/#{filename}")
  xlsx = Roo::Spreadsheet.open(tempfile)
  xlsx = Roo::Excelx.new(tempfile)

  xlsx.info

  call_sign = xlsx.sheet(0).column(3)
  @call_signs_b = call_sign.compact.uniq

  channel = xlsx.sheet(0).column(2)
  @channel_b = channel.compact.uniq

  # @call_signs_a = ["ESPNHD", "ESPN2HD", "ESPNWHD", "ESPNUHD", "SECH", "ESPNBGB", "USNHD", "UNIHD", "UNIMHD", "UDNHD", "ESPNDHD", "BEIN1HD", "BEIN2", "AZTECAE", "HBO", "EPIXHD", "EPIX2HD", "EPIX3HD", "EPDVN", "AMCHD", "AMCSTR", "TNTHD", "AESTR", "AETVHD", "HISSTR", "HISTORY", "H2STR", "H2HD", "TBSHD", "IFCSTR", "IFCHD", "SUNSTR", "SUNDHD", "TCMHD", "ELREY", "POLARIS", "MAKER", "TRUTVHD", "CINLUS", "DEPELUS", "DEPELC", "PASNUS", "UNITLNO", "AZCORA", "HGTVD", "DIYHD", "FYIHD", "FYISTR", "FOODHD", "TRAVHD", "COOKHD", "TOONHD", "ABCFHD", "ABCFHDP", "DISNHD", "DISNHDP", "DJCHHD", "DJCHHDP", "DXDHD", "DXDHDP", "BOOM", "BABYUS", "DUCKTV", "CNNHD", "HLNHD", "BLOOMHD", "EURONEW", "F24EN", "NEW18", "NDTV2", "RTTV", "WEHD", "WETVSTR", "LIFEHD", "LIFESTR", "LMNHD", "LMNSTR", "GALAHD", "TELEROM", "THITUS", "BANDAUS", "NUESTRT", "ANT3I", "NUESTRA", "TVEA2", "FOROTVD", "TFORM", "CBEETV", "BABYTVL", nil, "ESPNGLH", "ESPNBLH", "ADSWMDM", "OWSPN", "NATCL", "TRCSPSI", "MBC1", "MURRTV", "NEWTV", "ALJZ", "ARABIYA", "MBCKD", "LDC", "LBC", "DREAM2", "ALYAUM", "ALNAHAR", "MBCM", "ARTAMER", "OTVLB", "YAHALA", "HKYAT", "ALHY1", "NBN", "TENEGYP", "ROTAN", "ESC1", "FUTURE", "ONTVUS", "BBCARAB", "JAZMUB", "MBCDR", "ARMO", "MACLASIC", "CIMA", "MAFLAM", "ARTA1", "ARTAF2", "HKYAT2", "ARTCN", "NILE", "MLDYH", "TARAB", "ARBMU", "DANDA", "IQRAA", "NOURSAT", "AGHAPY", "ALHYC", "ATNBANG", "NTV1", "AATH", "TARAM", "ETVBG", "ZEEMR", "CHNLI", "RGTI", "PFC", "RECI", "BANDINT", "BANDN", "TVBS", "TVBE", "TVB2", "TVB1", "NOWTV", "NBNC", "NOWHAI", "KAPATID", "AKSYN", "TV9", "SETHHD", "SETMX", "ZCIN", "ASIA", "TIMES", "AASTH", "AAJTK", "CLRS", "B4U", "B4UMUS", "SAB", "SAHARA", "SSRASH", "LOK", "SPLUS", "ZEETVH", "WLLOHD", "MTVIND", "BIGMGC", "SONYM", "NDGT", "MOK", "ATNFF", "UDAYA", "ETVKN", "ZEEKA", "HB", "RSHTY", "ETVMA", "SURYA", "KAIRALI", "KIRAN", "MNRMA", "ASIANT", "ASNPL", "ASNMV", "ASNNW", "KAIRWE", "PEOPL", "PHNIN", "CCENT", "BEJTV", "PNAX", "DRAGN", "ZJTV", "HUNAN", "CCTVE", "ANHTV", "GUAND", "CCMOV", "CYRTV", "FUJTV", "CATHAYD", "SZTV", "ATVHC", "CQTV", "JIG", "CCTVNWS", "CCOPR", "CCTV4", "XIAMEN", "PUNJA", "GPUNJ", "JUSPUNJ", "PTC", "MH1", "IKKONK", "JUSCO", "9XTAS", "ETNEW", "FTVTW", "SKYLINK", "ETGLOB", "SETINTL", "TTV", "SCC", "ETFINWS", "ETDRA", "JETTV", "CTSI", "ETCHI", "YOYO", "SKYLNK2", "CHNLV", "GETV", "UBN", "SUNTV", "KTV1", "SUNMTV", "ADTYA", "JAYATV", "JMAX", "JAYA", "KLGNRTV", "SRPPLTV", "SVJAY", "JMOV", "RAJTV", "RAJDP", "RAJN", "RAJM", "ZEETE", "TELUG", "GEMITV", "GEMNMV", "GCMDY", "MAATV", "TV5NW", "TV9TE", "MAAMOV", "MAMUSIC", "MAGOLD", "BHAKT", "NTVTE", "VANIT", "SVBC", "SNEHATV", "GEOTV", "ARYDI", "ARYNEWS", "PTVGLB", "EXPNW", "GEONWS", "QTVPAK", "ARYZAUQ", "DUNYA", "EXPEN", "TVBV", "FASHSD", "EBRUTV", "BONTV", "EURCH", "TRACEE", "LUXE", "RITTVD", "ZOOMUSA"]
  # p @call_signs_a.size

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

  p @xlsx_hash.size 

  call_signs_a = @call_signs_j.compact.uniq - @call_signs_b.compact.uniq
  call_signs_b = @call_signs_b.compact.uniq - @call_signs_j.compact.uniq
  call_signs_b.shift
  @call_signs_a = call_signs_a.sort
  @call_signs_b = call_signs_b.sort

  erb :upload
  # => Returns basic info about the spreadsheet file

end
