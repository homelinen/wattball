# Circumvent lazy loading of classes
if Rails.env.development?
  %w[athlete wattball_player].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end
