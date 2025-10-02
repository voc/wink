# (W)o (i)st mei(n)e Winke(k)atze?

C3VOC inventory and transport planning interface.


## Install

Clone repository.

```
 git clone https://github.com/voc/wink;
 cd wink
```

Install dependencies.

```
 bundle install
```

Create database and add test data.

```
 rake db:drop db:create db:migrate db:seed
```

Run application
```
 bin/rails server
```

## API

A real API is not implemented yet. Nevertheless you cann call `.json` to some of
the views to get an JSON output:

```
GET /check_lists.json
GET /check_lists/:id.json
```

`events`, `items` and `cases` are also ready for this.


## Deployment

```shell
export OIDC_ISSUER=https://accounts.google.com
export OIDC_CLIENT_ID=YOUR_CLIENT_ID
export OIDC_CLIENT_SECRET=YOUR_CLIENT_SECRET
export OIDC_REDIRECT_URI=https://localhost:3000/auth/oidc/callback
bin/rails s
```

## License

Copyright (c) 2018, c3voc<br>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
