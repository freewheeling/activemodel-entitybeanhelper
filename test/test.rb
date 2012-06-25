require 'java'
require 'lib/activemodel-entitybeanhelper'
require 'test/EntityBeanTest.jar'

java_import com.hypermatix.entitybean.test.EntityBean

class ActiveModelBean < Java::ComHypermatixEntitybeanTest::EntityBean
  extend ActiveModel::EntityBeanHelper
end

#Test that NonNull entity property becomes 'required' in sub-classed ruby ActiveModel object
@rubybean = ActiveModelBean.new
puts "Ruby ActiveRecord Valid? : #{@rubybean.valid?}"
puts "Assigning value to NonNull property..."
@rubybean.testProperty = "Has NonNull Value!"
puts "Ruby ActiveRecord Valid? : #{@rubybean.valid?}"

puts ""
#Test that ruby ActiveModel object can be initialized (i.e. properties set)
#from a java entity bean object
@initbean = Java::ComHypermatixEntitybeanTest::EntityBean.new
@initbean.testProperty = "Prop1 Value"
@initbean.secondTestProperty = "Prop2 Value"
puts "New Entity Bean: {TestProperty='#{@initbean.testProperty}',SecondTestProperty='#{@initbean.secondTestProperty}'}"

@rubybean = ActiveModelBean.new(@initbean)
puts "Ruby ActiveRecord initialized from New Entity Bean: {TestProperty='#{@rubybean.testProperty}',SecondTestProperty='#{@rubybean.secondTestProperty},valid?=#{@rubybean.valid?}'}"


