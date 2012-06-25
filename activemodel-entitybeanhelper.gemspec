Gem::Specification.new do |s|
  s.name    = 'activemodel-entitybeanhelper'
  s.version = '0.0.1'
  s.summary = 'Reflect Java EntityBeans into Ruby ActiveModel objects for validation'
  s.authors = ["Brendan Whelan"]
  s.files = Dir['{lib}/*']
  s.add_dependency 'activemodel'
end
