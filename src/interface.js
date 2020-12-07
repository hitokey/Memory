import { FocusEvent, RefObject, SyntheticEvent } from "react";

type FormValues = Record<string, any>;

type DeepProps<V, T = any> = {
  [K in keyof V]?: V[K] extends T ? T : DeepProps<V[K]>;
};

type Errors<V> = DeepProps<V>;

type FormState<V = FormValues> = Readonly<{
  values: V;
  touched: DeepProps<V, boolean>;
  errors: Errors<V>;
  isDirty: boolean;
  dirtyFields: DeepProps<V, boolean>;
  isValidating: boolean;
  isValid: boolean;
  isSubmitting: boolean;
  isSubmitted: boolean;
  submitCount: number;
}>;

type Options<V> = Omit<Return<V>, "form" | "field" | "submit" | "controller">;

interface OnReset<V = FormValues> {
  (
    values: V,
    options: Omit<Options<V>, "reset">,
    event?: Event | SyntheticEvent<any>
  ): void;
}

interface OnSubmit<V = FormValues> {
  (
    values: V,
    options: Options<V>,
    event?: Event | SyntheticEvent<any>
  ): void | Promise<void>;
}

interface OnError<V = FormValues> {
  (
    errors: Errors<V>,
    options: Options<V>,
    event?: Event | SyntheticEvent<any>
  ): void;
}

interface Debug<V> {
  (formState: FormState<V>): void;
}

interface FormValidator<V = FormValues> {
  (values: V): Errors<V> | void | Promise<Errors<V> | void>;
}

interface FieldValidator<V = FormValues> {
  (value: any, values: V): any | Promise<any>;
}

interface FieldRef<V> {
  (
    validateOrOptions:
      | FieldValidator<V>
      | {
          validate?: FieldValidator<V>;
          valueAsNumber?: boolean;
          valueAsDate?: boolean;
          parse?: Parse;
        }
  ): (
    field: HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement | null
  ) => void;
}

interface GetState {
  (
    path: string | string[] | Record<string, string>,
    options?: {
      target?: string;
      watch?: boolean;
      filterUntouchedErrors?: boolean;
    }
  ): any;
}

interface SetErrors<V> {
  (
    errors?: Errors<V> | ((previousErrors: Errors<V>) => Errors<V> | undefined)
  ): void;
}

interface SetFieldError {
  (name: string, error?: any | ((previousError?: any) => any)): void;
}

type ValuesArg<V> = V | ((previousValues: V) => V);

interface SetValues<V> {
  (
    values: ValuesArg<V>,
    options?: {
      shouldValidate?: boolean;
      touchedFields?: string[];
      dirtyFields?: string[];
    }
  ): void;
}

interface SetFieldValue {
  (
    name: string,
    value: any | ((previousValue: any) => any),
    options?: {
      [k in "shouldValidate" | "shouldTouched" | "shouldDirty"]?: boolean;
    }
  ): void;
}

interface ValidateForm<V> {
  (): Promise<Errors<V>>;
}

interface ValidateField<V> {
  (name: string): Promise<Errors<V>>;
}

interface Reset<V> {
  (
    values?: ValuesArg<V> | null,
    exclude?: (keyof FormState<V>)[] | null,
    event?: SyntheticEvent<any>
  ): void;
}

interface Submit<V> {
  (event?: SyntheticEvent<any>): Promise<{ values?: V; errors?: Errors<V> }>;
}

interface Parse<V = any, R = any> {
  (value: V): R;
}

type Format<V = any, R = any> = Parse<V, R>;

interface OnChange<E = any> {
  (event: E, value?: any): void;
}

interface OnBlur {
  (event: FocusEvent<any>): void;
}

interface Controller<V = FormValues, E = any> {
  (
    name: string,
    options?: {
      validate?: FieldValidator<V>;
      value?: any;
      defaultValue?: any;
      parse?: Parse;
      format?: Format;
      onChange?: OnChange<E>;
      onBlur?: OnBlur;
    }
  ): {
    name: string;
    value: any;
    onChange: (event: E) => void;
    onBlur: OnBlur;
  } | void;
}

interface Config<V = FormValues> {
  defaultValues: V;
  validate?: FormValidator<V>;
  validateOnChange?: boolean;
  validateOnBlur?: boolean;
  ignoreFields?: string[];
  onReset?: OnReset<V>;
  onSubmit?: OnSubmit<V>;
  onError?: OnError<V>;
  debug?: Debug<V>;
}

interface Return<V = FormValues> {
  form: RefObject<HTMLFormElement>;
  field: FieldRef<V>;
  getState: GetState;
  setErrors: SetErrors<V>;
  setFieldError: SetFieldError;
  setValues: SetValues<V>;
  setFieldValue: SetFieldValue;
  validateForm: ValidateForm<V>;
  validateField: ValidateField<V>;
  reset: Reset<V>;
  submit: Submit<V>;
  controller: Controller<V>;
}

const useForm: <V extends FormValues = FormValues>(
  config: Config<V>
) => Return<V>;

const get: (object: any, path: string, defaultValue?: unknown) => any;

const set: (
  object: any,
  path: string,
  value: unknown,
  immutable?: boolean
) => any;

const unset: (object: any, path: string, immutable?: boolean) => any;
