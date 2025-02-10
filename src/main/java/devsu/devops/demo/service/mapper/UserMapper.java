package devsu.devops.demo.service.mapper;

import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import devsu.devops.demo.entity.User;
import devsu.devops.demo.service.dto.UserDto;

@Component
@RequiredArgsConstructor
public class UserMapper {
    private final ModelMapper modelMapper;

	public UserDto toDto(User user) {
        return modelMapper.map(user, UserDto.class);
	}

	public User toEntity(UserDto userDto) {
		User user = modelMapper.map(userDto, User.class);
	    return user;
	}
}
