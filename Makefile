# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: apintus <apintus@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/17 14:48:41 by apintus           #+#    #+#              #
#    Updated: 2025/03/06 17:19:02 by apintus          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                                  VARIABLES                                   #
# **************************************************************************** #

END				=	\033[0m

# COLORS

GREY			=	\033[0;30m
RED				=	\033[0;31m
GREEN			=	\033[0;32m
YELLOW			=	\033[0;33m
BLUE			=	\033[0;34m
PURPLE			=	\033[0;35m
CYAN			=	\033[0;36m
WHITE			=	\033[0;37m

# **************************************************************************** #
#                                   COMMAND                                    #
# **************************************************************************** #

DOCKER_COMPOSE := dokcer compose

# **************************************************************************** #
#                                   SOURCES                                    #
# **************************************************************************** #

SRCS 			=	./srcs

DOCKER_COMPOSE_FILE = $(SRCS)/docker-compose.yml

# **************************************************************************** #
#                                   VOLUMES                                    #
# **************************************************************************** #

USER_HOME = $(shell echo ~)

# **************************************************************************** #
#                                    RULES                                     #
# **************************************************************************** #

all: create_volumes up

up:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v --remove-orphans

re: down up

logs:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f

clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v --remove-orphans --rmi all
	@echo "${YELLOW}> Docker down has been done ❌${END}\n"

fclean:	clean
	@sudo rm -rd $(USER_HOME)/data/mysql
	@sudo rm -rd $(USER_HOME)/data/wordpress
	@echo "${YELLOW}> Cleaning volumes has been done ❌${END}\n"

create_volumes:
	@echo "${YELLOW}> Creating volumes...${END}"
	@mkdir -p $(USER_HOME)/data/mysql
	@mkdir -p $(USER_HOME)/data/wordpress
	@echo "${GREEN}> Volumes created ✔️${END}\n"

.PHONY: all up down clean re fclean create_volumes logs
