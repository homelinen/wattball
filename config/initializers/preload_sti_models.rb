# Circumvent lazy loading of classes
if Rails.env.development?
  %w[athlete wattballPlayer].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end
