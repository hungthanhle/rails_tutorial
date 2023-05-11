FactoryBot.define do
  factory :notification do
    user { nil }
    notification_with_id { 1 }
    notice_type { 1 }
    read { false }
    checked { false }
  end
end
