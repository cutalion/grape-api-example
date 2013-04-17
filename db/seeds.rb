partners = %W(#{"Google"} #{"Apple"})

partners.each do |name|
  partner = Partner.where(business_name: name)
  partner.create unless partner.exists?
end
