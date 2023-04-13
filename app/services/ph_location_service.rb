class PhLocationService
  attr_reader :url

  def initialize
    @url = 'https://psgc.gitlab.io/api'
  end

  def fetch_region
    request = RestClient.get("#{url}/regions/")
    data = JSON.parse(request.body)
    data.each do |region|
      address_region = Address::Region.find_or_initialize_by(code: region['code'])
      if address_region.new_record?
        puts 'New'
      else
        puts "update record id is #{address_region.id}"
      end
      address_region.name = region['regionName']
      address_region.save
    end
  end

  def fetch_province
    request = RestClient.get("#{url}/provinces/")
    data = JSON.parse(request.body)
    data.each do |province|
      address_province = Address::Province.find_or_initialize_by(code: province['code'])
      address_province.name = province['name']
      address_province.region = Address::Region.find_by_code(province['regionCode'])
      address_province.save
    end
  end
end