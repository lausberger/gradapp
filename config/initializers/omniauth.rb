Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
  provider :twitter, ENV['UrintRFExd6yhFN06TkdTBoh7'], ENV['cOkcRgqUE2BxFacEBUkHYNruMCecj9a7UezmRR2b6on4iRPD8C'], origin_param: false
end
