# Makefile for procfs-reader

# Define the source and build directories
SRCDIR := src
BUILDDIR := build
BINDIR := bin

# Define the CFLAGS for compilation
CFLAGS := -Wall -Wextra -pedantic -O2 -std=c11 -Iinclude

# Define the dependencies
DEPS := config.mk

# Define the source files
SRCS := $(wildcard $(SRCDIR)/main.c $(SRCDIR)/procfs.c $(SRCDIR)/utils.c)

# Define the test source files
TEST_SRCS := $(wildcard $(SRCDIR)/main.c $(SRCDIR)/test_procfs.c)

# Define the executable targets
BINDIRS := $(wildcard $(BINDIR)/procfs-reader)

# Define the clean target
CLEAN := rm -rf $(BUILDDIR) $(BINDIR)

# Define the all target
all: $(BINDIR)/procfs-reader
	@echo "procfs-reader built successfully"

# Define the build target
build: $(BUILDDIR)/procfs-reader.o $(BUILDDIR)/procfs.o $(BUILDDIR)/utils.o
	@gcc $(CFLAGS) -o $(BINDIR)/procfs-reader $(BUILDDIR)/procfs-reader.o $(BUILDDIR)/procfs.o $(BUILDDIR)/utils.o

# Define the procfs-reader.o target
$(BUILDDIR)/procfs-reader.o: $(SRCDIR)/main.c
	@mkdir -p $(BUILDDIR)
	@gcc $(CFLAGS) -c $(SRCDIR)/main.c -o $(BUILDDIR)/procfs-reader.o

# Define the procfs.o target
$(BUILDDIR)/procfs.o: $(SRCDIR)/procfs.c
	@mkdir -p $(BUILDDIR)
	@gcc $(CFLAGS) -c $(SRCDIR)/procfs.c -o $(BUILDDIR)/procfs.o

# Define the utils.o target
$(BUILDDIR)/utils.o: $(SRCDIR)/utils.c
	@mkdir -p $(BUILDDIR)
	@gcc $(CFLAGS) -c $(SRCDIR)/utils.c -o $(BUILDDIR)/utils.o

# Define the clean target
clean:
	$(CLEAN)

# Define the test target
test: $(BINDIR)/procfs-reader
	@echo "Running tests for procfs-reader"
	@gcc $(CFLAGS) $(TEST_SRCS) -o $(BINDIR)/test_procfs_reader
	@./$(BINDIR)/test_procfs_reader

# Define the install target
install:
	@mkdir -p /usr/local/bin
	@cp $(BINDIR)/procfs-reader /usr/local/bin

# Define the uninstall target
uninstall:
	@rm /usr/local/bin/procfs-reader