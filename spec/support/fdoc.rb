Fdoc.decide_success_with do |response_json, response_status|
  (200..299).cover? response_status
end
