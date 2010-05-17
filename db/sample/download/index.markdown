## Installation instructions:

<pre><code>
git clone 
cd martini
rake db:migrate
rake db:seed # if you want dummy data
rails server thin
</code></pre>

## Deployment

<pre><code>
heroku create --stack bamboo-ree-1.8.7 --remote bamboo my-app-name
git push bamboo master
heroku rake db:seed
heroku rake db:migrate
</code></pre>

## Github

Martini is actively developed on Github and is updated frequently with all the latest code developments and bug fixes between scheduled releases. If you want to be on the cutting edge, visit our Github project, fork the project, make changes, and submit requests.

## License

#### What you need to know

Martini is licensed under the open source MIT license, which allows you to use the script for whatever you want, whenever you want, however you want, as long as you include a copy of the license!

### So... that's it? Completely free?

Yep. No strings, no catches, just the code and your right to do anything you want with it.

#### The MIT license

Copyright © 2010 Lance Pollard

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.