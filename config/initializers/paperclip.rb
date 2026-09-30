
# use this setting when paperclip need to upload file

# aws

Paperclip::Attachment.default_options.merge!(
  storage: :s3,
  s3_region: ENV.fetch("AWS_REGION"),
  s3_credentials: {
    bucket: ENV.fetch("AWS_BUCKET"),
    access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
    secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY")
  },
  s3_protocol: "https",
  s3_acl_enabled: false
)
