import { HttpClient } from '@angular/common/http';
import { Component, inject } from '@angular/core';
import {
  FormBuilder,
  FormGroup,
  Validators,
  ReactiveFormsModule,
} from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrl: './login.component.css',
  imports: [ReactiveFormsModule],
})
export class LoginComponent {
  loginForm: FormGroup;

  constructor(private fb: FormBuilder) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: [],
    });
  }

  http = inject(HttpClient);
  router = inject(Router);

  onLogin() {
    if (this.loginForm.valid) {
      this.http
        .post(
          'https://projectapi.gerasim.in/api/EmployeeManagement/login',
          this.loginForm.controls
        )
        .subscribe((res: any) => {
          if (res.result) {
            localStorage.setItem('user_data', JSON.stringify(res.data));
            this.router.navigateByUrl('dashboard');
          } else {
            alert(res.message);
          }
        });
      this.loginForm.reset();
    }
  }
}
