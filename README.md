activemodel-entitybeanhelper
============================

JRuby helper to reflect Java entity beans as rails ActiveModel validation objects.

This is a proof-of-concept jruby gem that allows for
rails activemodel classes to be created as sub-classes 
of java entitybean classes, so that the entity bean 
property values and validation attributes will be carried 
across to ruby on rails ActiveModel equivalent. 
This allows for rails' in-built active model validation 
to be used for quick Presentation Layer validation of 
the object, without having to make a call to the business
layer, and without haivng to duplicate validation attribute
information in the code of the presentation layer (the entity
bean codes maintain the business object validation info).

Needs to be extended to handle all validation types, and
property types (collections, etc.)

To try it: jruby test/test.rb