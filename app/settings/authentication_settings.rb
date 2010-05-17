class AuthenticationSettings < Configuration
  
  preference :use_open_id, :default => true
  preference :use_oauth, :default => true
  
end