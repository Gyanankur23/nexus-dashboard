# Contributing Guidelines

Thank you for your interest in contributing to Nexus Dashboard!

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, include:

- A clear and descriptive title
- Steps to reproduce the issue
- Expected behavior
- Actual behavior
- Screenshots if applicable
- Environment details (OS, Node.js version, Dart version)

### Suggesting Enhancements

Enhancement suggestions are welcome! Please:

- Use a clear and descriptive title
- Provide a detailed description of the proposed enhancement
- Explain why this enhancement would be useful
- Provide examples of how the enhancement would be used

### Pull Requests

1. Fork the repository
2. Create a new branch for your feature (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

### Coding Standards

- Follow the existing code style
- Write clear, descriptive commit messages
- Add comments for complex logic
- Keep functions small and focused
- Use meaningful variable and function names

### Frontend (Vue.js)

- Use Vue 3 Composition API
- Follow Vue style guide
- Use Pinia for state management
- Use Tailwind CSS for styling
- Keep components reusable

### Backend (Dart)

- Follow Dart style guide
- Use async/await for asynchronous operations
- Write clean, readable code
- Add error handling
- Document API endpoints

## Development Setup

```bash
# Clone the repository
git clone https://github.com/Gyanankur23/nexus-dashboard.git
cd nexus-dashboard

# Setup backend
cd backend
dart pub get
dart run bin/server.dart

# Setup frontend (in new terminal)
cd frontend
npm install
npm run dev
```

## Testing

- Test your changes thoroughly
- Ensure both frontend and backend work together
- Test on different browsers
- Check responsive design

## Documentation

- Update documentation for any new features
- Keep README.md up to date
- Document any API changes in API.md
- Update architecture docs if needed

## License

By contributing, you agree that your contributions will be licensed under the MIT License.