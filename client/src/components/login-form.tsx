"use client";

import * as React from "react";
import Link from "next/link";
import { Button } from "./ui/button";
import { Input } from "./ui/input";
import { Label } from "./ui/label";
import { Icons } from "./icons";
import { motion } from "motion/react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { loginSchema, LoginInput } from "@/features/auth/schemas";
import { useLogin } from "@/features/auth/hooks/use-auth";

export function LoginForm() {
  const [showPassword, setShowPassword] = React.useState(false);
  const { mutate: login, isPending } = useLogin();

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<LoginInput>({
    resolver: zodResolver(loginSchema),
    defaultValues: {
      email: "",
      password: "",
    },
  });

  const onSubmit = (data: LoginInput) => {
    login(data);
  };

  const container = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1,
        delayChildren: 0.3,
      },
    },
  };

  const item = {
    hidden: { opacity: 0, y: 20 },
    show: { opacity: 1, y: 0 },
  };

  return (
    <motion.form 
      onSubmit={handleSubmit(onSubmit)} 
      className="flex flex-col gap-4"
      variants={container}
      initial="hidden"
      animate="show"
    >
      <motion.div variants={item} className="flex flex-col gap-2">
        <Label htmlFor="email">Email</Label>
        <Input
          id="email"
          type="email"
          placeholder="Enter your email address"
          leftIcon={<Icons.Mail />}
          {...register("email")}
        />
        {errors.email && (
          <p className="text-sm text-red-500">{errors.email.message}</p>
        )}
      </motion.div>
      <motion.div variants={item} className="flex flex-col gap-2">
        <Label htmlFor="password">Password</Label>
        <Input
          id="password"
          type={showPassword ? "text" : "password"}
          placeholder="Enter your password"
          leftIcon={<Icons.Lock />}
          rightElement={
            <button
              type="button"
              onClick={() => setShowPassword(!showPassword)}
              className="focus:outline-none"
              aria-label={showPassword ? "Hide password" : "Show password"}
            >
              {showPassword ? (
                <Icons.VisibilityOff />
              ) : (
                <Icons.Visibility />
              )}
            </button>
          }
          {...register("password")}
        />
        {errors.password && (
          <p className="text-sm text-red-500">{errors.password.message}</p>
        )}
      </motion.div>
      <motion.div variants={item} className="flex items-center justify-end">
        <Link
          href="#"
          className="text-primary hover:underline text-sm font-medium leading-normal"
        >
          Forgot Password?
        </Link>
      </motion.div>
      <motion.div variants={item}>
        <Button type="submit" className="relative overflow-hidden" disabled={isPending}>
          <motion.span
            initial={{ y: 20, opacity: 0 }}
            animate={{ y: 0, opacity: 1 }}
            transition={{ delay: 0.6, duration: 0.4 }}
            className="truncate"
          >
            {isPending ? "Logging in..." : "Login"}
          </motion.span>
        </Button>
      </motion.div>
    </motion.form>
  );
}
