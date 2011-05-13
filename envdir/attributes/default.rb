=begin
 env_vars looks like:
   {
     :monkey => {
       :s3    => { "AWS_KEY" => "123", "AWS_SECRET => "456" },
       :rails => { "RACK_ENV" => "development" }
     },
     :postfix => {
       :sendgrid => { "API_KEY" => "Something" #     }
     }
   }

 This would create
   /etc/env (mode 755, owned by root)
   /etc/env/s3 (owned by monkey)
   /etc/env/s3/AWS_KEY (w/ value 123, owned by monkey)
   /etc/env/s3/AWS_KEY (w/ value 123, owned by monkey)
   /etc/env/sendgrid (owned by postfix)
   /etc/env/sendgrid/API_KEY (w/ value of Something

Later, if access needs to be determined by groups,
this format would need to change.  But it can be users
for me for now.

=end

default[:env_vars] = {}
