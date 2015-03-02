class Card < ActiveRecord::Base

  has_attached_file :avatar,
                    :storage => :s3,
                    :s3_credentials => Proc.new{ |a| a.instance.s3_credentials {,
                    :styles => {
                      thumb: '100x100',
                      square: '200x200#',
                      medium: '300x300>'
                    },
                    :default_url => "/images/:style/missing.gif"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def s3_credentials
    { :bucket => ENV['S3_BUCKET'], :access_key_id => ENV['ACCESS_KEY_ID'], :secret_access_key => ENV['SECRET_ACCESS_KEY']}
  end

end
