
layout      'default.html.erb'

post_path   'post'
output_path 'public'

post 'hello.md', :layout => 'another.html.erb'
list 'list'    , :layout => 'another.html.erb'
