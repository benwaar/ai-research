# Using GitHub Copilot to write unit tests

**By David.Benoy**  
*2 min read*

## Introduction

GitHub Copilot has revolutionized how developers approach unit testing by automating much of the boilerplate code generation. However, to use it effectively, you need a solid foundation in testing principles and troubleshooting skills.

**Prerequisites**: Before diving into AI-assisted testing, ensure you understand unit testing fundamentals and code coverage analysis. This knowledge will help you evaluate and improve Copilot's output.

See this useful overview on the principles of writing good unit tests:
- [The 5 principles of Unit Testing](https://medium.com/@pjbgf/title-5-characteristics-of-a-good-unit-test-c5d83a53e68b)

See this article on code coverage:
- [What is Code Coverage? | Atlassian](https://www.atlassian.com/continuous-delivery/software-testing/code-coverage)

## Useful articles

A couple of articles about writing tests with Copilot worth reading are:

- [Writing tests with GitHub Copilot - GitHub Docs](https://docs.github.com/en/copilot/using-github-copilot/writing-tests-with-github-copilot)
- [How to generate unit tests with GitHub Copilot: Tips and examples](https://github.blog/2024-03-25-how-to-generate-unit-tests-with-github-copilot/)

## Getting Started

Follow this three-phase approach for maximum success:

### Phase 1: Generate Basic Scaffolding
1. **Setup**: Ensure GitHub Copilot is installed and active
2. **Context**: Open the source file you want to test (or existing test file)
3. **Generate**: Use the `/test` command in Copilot Chat to generate initial test structure

💡 **Pro Tip**: The `/test` command is a powerful shortcut that analyzes your code and creates comprehensive test scaffolding.

### Phase 2: Fix Setup Issues
Run the generated tests immediately to identify and resolve configuration problems. This step is crucial as Copilot often generates syntactically correct code that fails due to environment setup issues.

### Phase 3: Enhance Test Coverage
Once basic tests run successfully, iteratively improve them by adding edge cases, error scenarios, and more specific assertions.

## Troubleshooting Generated Tests

⚠️ **Reality Check**: While Copilot excels at generating test structure, it often struggles with environment-specific configurations and dependencies.

**Action Required**: Always run generated tests immediately to identify issues early. The faster you catch problems, the easier they are to fix.

## How to Fix Problems When Copilot Fails

When GitHub Copilot generates unit tests that don't work, here's a systematic approach to troubleshoot and fix them:

### 1. Common Import and Module Issues

**Problem**: Missing or incorrect imports
- Copilot may not include all necessary imports
- May use incorrect module paths

**Solution**:
```typescript
// Add missing imports at the top of the test file
import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { of } from 'rxjs';
```

### 2. Test Environment Setup Issues

**Problem**: Missing test bed configuration or providers
- Angular components need proper TestBed setup
- Services may require mocked dependencies

**Solution**:
```typescript
beforeEach(async () => {
  await TestBed.configureTestingModule({
    declarations: [YourComponent],
    imports: [HttpClientTestingModule, RouterTestingModule],
    providers: [
      { provide: YourService, useValue: mockService }
    ]
  }).compileComponents();
});
```

### 3. Mock and Spy Configuration

**Problem**: Inadequate or incorrect mocking
- Services not properly mocked
- Spies not configured correctly

**Solution**:
```typescript
// Create proper mocks
const mockService = jasmine.createSpyObj('YourService', ['method1', 'method2']);
mockService.method1.and.returnValue(of(mockData));

// Or use jest mocks
const mockService = {
  method1: jest.fn().mockReturnValue(Promise.resolve(mockData))
};
```

### 4. Async Testing Issues

**Problem**: Promises or Observables not handled correctly
- Tests completing before async operations finish
- Missing proper async/await or subscribe patterns

**Solution**:
```typescript
// For Promises
it('should handle async operation', async () => {
  const result = await service.asyncMethod();
  expect(result).toBe(expectedValue);
});

// For Observables
it('should handle observable', (done) => {
  service.getObservable().subscribe(result => {
    expect(result).toBe(expectedValue);
    done();
  });
});
```

### 5. DOM and Component Testing Fixes

**Problem**: Component rendering or DOM manipulation issues
- Missing fixture detection changes
- Incorrect element selection

**Solution**:
```typescript
it('should render correctly', () => {
  component.property = testValue;
  fixture.detectChanges(); // Trigger change detection
  
  const element = fixture.debugElement.nativeElement;
  const button = element.querySelector('button');
  expect(button.textContent).toContain('Expected Text');
});
```

### 6. Systematic Debugging Approach

When tests fail, resist the urge to randomly change code. Instead, follow this methodical process:

#### Step-by-Step Debugging Process

1. **🔍 Analyze Error Messages**
   - Read the full error stack trace
   - Identify the exact line and operation causing failure
   - Look for keywords like "undefined", "not found", or "timeout"

2. **🖥️ Check Browser Console**
   - Open browser dev tools for additional context
   - Look for network errors, console warnings, or uncaught exceptions

3. **📦 Verify Dependencies**
   - Confirm all imports are correct and available
   - Check that test utilities and frameworks are properly installed

4. **🎭 Validate Mock Configuration**
   - Ensure mocks return appropriate data types
   - Verify spy methods match actual service interfaces
   - Check that async mocks resolve/reject correctly

5. **🔬 Add Diagnostic Logging**
   ```typescript
   console.log('Input data:', inputData);
   console.log('Service response:', mockService.getData.calls.all());
   ```

6. **🎯 Isolate the Problem**
   - Run individual test cases to identify specific failures
   - Use `fdescribe` or `fit` to focus on problematic tests

7. **🐛 Use IDE Debugging Tools**
   - Set breakpoints in both test and source code
   - Step through execution to understand data flow

### 7. Common Error Patterns and Fixes

| Error Type | Common Cause | Quick Fix |
|------------|--------------|-----------|
| `Cannot read property of undefined` | Missing mock return value | Add `.and.returnValue()` to spy |
| `Module not found` | Incorrect import path | Check and fix import statements |
| `No provider for...` | Missing service in TestBed | Add to providers array |
| `ExpressionChangedAfterItHasBeenCheckedError` | Missing detectChanges() | Add `fixture.detectChanges()` |
| `Timeout` in async tests | Missing done() or await | Properly handle async operations |

### 8. Maximizing Copilot Effectiveness

Transform Copilot from a basic code generator into a powerful testing assistant with these strategies:

#### Craft Better Prompts
- ❌ Vague: "Write tests for this component"
- ✅ Specific: "Write unit tests for the UserService.authenticateUser() method covering success, invalid credentials, and network timeout scenarios"

#### Optimize Your Workspace Context
- Keep related files open: service interfaces, models, and existing tests
- Ensure your test framework configuration is visible
- Have mock data examples readily available

#### Use Iterative Refinement
1. Start with basic test generation using `/test`
2. Ask for specific scenarios: "Add tests for edge cases"
3. Request performance tests: "Add tests to verify response time"
4. Enhance assertions: "Make the assertions more specific"

#### Best Practices for Prompting
- **Include expected behavior**: "The method should return a User object when authentication succeeds"
- **Specify test framework**: "Using Jest and Angular Testing Library"
- **Mention dependencies**: "Mock the HttpClient and Router services"
- **Request specific patterns**: "Use AAA pattern (Arrange, Act, Assert)"

### 9. When to Write Tests Manually

Recognize when manual testing is more efficient than AI assistance:

#### Manual Testing is Better For:
- **🧠 Complex Business Logic**: Multi-step workflows with intricate validation rules
- **🔗 Integration Tests**: Cross-system testing requiring specific environment setup
- **🎭 Advanced Mocking**: Complex spy chains, partial mocks, or custom test doubles
- **⚡ Performance Tests**: Load testing, memory usage validation, or timing-critical operations
- **🔒 Security Tests**: Authentication flows, permission validations, or sensitive data handling

#### Hybrid Approach - Best of Both Worlds:
1. Use Copilot for **test structure and boilerplate**
2. Manually add **business logic assertions**
3. Let Copilot generate **data setup and teardown**
4. Manually craft **edge case scenarios**

## Conclusion

GitHub Copilot transforms unit testing from a tedious chore into an efficient, iterative process. The key to success lies in understanding both its strengths (rapid scaffolding, boilerplate generation) and limitations (environment setup, complex business logic).

### Key Takeaways:
- 🚀 **Start Fast**: Use `/test` for quick scaffolding
- 🔧 **Fix Early**: Run tests immediately to catch setup issues
- 🎯 **Be Specific**: Detailed prompts yield better results
- 🔄 **Iterate**: Continuously refine and enhance generated tests
- 🧠 **Stay Engaged**: Review and understand all generated code

Remember: Copilot is a powerful assistant, but you remain the architect of your test strategy. Use it to accelerate development while maintaining code quality and coverage standards.

