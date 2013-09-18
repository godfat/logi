
post_path   'post'
layout_path 'layout'
output_path 'public'

layout 'default.html.erb'

post 'hello.md', :layout => 'another.html.erb'
list 'list'    , :layout => 'another.html.erb'
