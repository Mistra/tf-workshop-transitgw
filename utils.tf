# RSA key pair
resource "aws_key_pair" "mistrio" {
  key_name   = "mistrio"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCccYKbu0MdvTUPzGJDYMaN0Gtxu0qFRuRg3AW3wjyWkdwZOM8oSyubIiEHSvRUIpMiFdMEPAUEGyriDG1SXnsr/ifSJurfb7zzyQH357eXgno2YCRyJLfsd2kapuADj+PFUh4M4rt5QLQhBrGtyRHz/W6LJAlstVgGoz63wbyT3XjsvruIS2+lJw/nw2nnYok6F75PhAjKO1+vsKHd5DEeXWvqH+qUWewO53uL9PAvFqZHRvSUfG9zIbxlNgoV8++59uxHF+2vfd7wHDHTvL09VCEV4J2NxGwBptJhb97zlj6KNZl9gLDIDfMrnz3Yi79totgLDix2FHnqDPc0lJlOGM53s2oCVsOfqpoyzRxm5Z1mcKSlMi0iGSF6h+1UTJrrDy69J3TpO5k3xtEBgs/8RK+2I0HgjKQR7U2WLk9pdKPyR4rs7NAErzVUYIvVlZzedh5OMea2e9hFabDtKPAeXsWu4yGa9IiWUzhs7hPI9EdELyxXB11l6pdlRs8w68U= sperectrum@gmail.com"
}
