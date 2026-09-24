
# use this setting when paperclip need to upload file 
Paperclip::Attachment.default_options.merge!(
  storage: :s3,

  s3_region: ENV.fetch("B2_REGION"),

  s3_credentials: {
    bucket: ENV.fetch("B2_BUCKET"), # store image in this bucket 
    access_key_id: ENV.fetch("B2_ACCESS_KEY_ID"), # who i am
    secret_access_key: ENV.fetch("B2_SECRET_ACCESS_KEY") # i have authorization
  },

  s3_host_name: ENV.fetch("B2_ENDPOINT").sub("https://", ""),  # for making url 

  s3_options: { # request destination
    endpoint: ENV.fetch("B2_ENDPOINT"),
    force_path_style: true #put buket in url path
  },

  # url: ":s3_path_url", # for making attachment url , use s3 path style url
   s3_permissions: "private",
  s3_protocol: "https" # make url using https 
)