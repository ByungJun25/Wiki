#!/usr/bin/env ruby
require 'rubygems'
require 'gollum/app'

gollum_path = File.expand_path(File.dirname(__FILE__)) # CHANGE THIS TO POINT TO YOUR OWN WIKI REPO
Precious::App.set(:gollum_path, gollum_path)
Precious::App.set(:default_markup, :markdown) # set your favorite markup language
Precious::App.set(:wiki_options, {:universal_toc => false})

# Add in commit user/email
class Precious::App
    before do
        session['gollum.author'] = {
            :name       => `git config --get user.name `.strip,
            :email      => `git config --get user.email `.strip,
        }
    end
end