plot:
	@echo ""
	@echo "-------------------------------------------------------------------------------"
	@echo "  💡 Help  🧠"
	@echo "-------------------------------------------------------------------------------"
	@echo ""
	@echo " Options: "
	@echo "   make                           # Show this message"
	@echo "   make install                   # Install all the gems"
	@echo ""
	@echo "   make 2d_raycasting						 # Run the 2D raycasting simulation"
	@echo "   make 2d_shadowing              # Run the 2D shadowing simulation"

APP_DIR := $(shell pwd)

# Build the container -----------------------------------------------------------------------------
install:
	@echo "Installing gems"
	@bundle install

# Run the 2D casting simulation -------------------------------------------------------------------
2d_raycasting:
	@echo "Running 2D casting simulation"
	@ruby 2d_raycasting.rb

# Run the 2D shadowing simulation -----------------------------------------------------------------
2d_shadowing:
	@echo "Running 2D shadowing simulation"
	@ruby 2d_shadowing.rb
