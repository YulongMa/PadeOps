module sgrid_hooks
    use kind_parameters, only: rkind
    use decomp_2d, only: decomp_info
    use DerivativesMod, only: derivatives
    use FiltersMod, only: filters
    implicit none

    interface meshgen
        subroutine meshgen(decomp, dx, dy, dz, mesh)
            import :: rkind
            import :: decomp_info
            type(decomp_info), intent(in) :: decomp
            real(rkind), intent(inout) :: dx, dy, dz
            real(rkind), dimension(:,:,:,:), intent(in) :: mesh

        end subroutine 
    end interface

    interface initfields
        subroutine initfields(decomp,dx,dy,dz,inputfile,mesh,fields,eostype,eosparams,rho0,tstop,dt,tviz)
            import :: rkind
            import :: decomp_info
            type(decomp_info), intent(in) :: decomp
            real(rkind), intent(inout) :: dx, dy, dz
            character(len=*), intent(in) :: inputfile
            real(rkind), dimension(:,:,:,:), intent(in) :: mesh
            real(rkind), dimension(:,:,:,:), intent(inout) :: fields
            integer,                         intent(in)    :: eostype
            real(rkind), dimension(:),       intent(inout) :: eosparams
            real(rkind),           optional, intent(inout) :: rho0, tstop, dt, tviz

        end subroutine 
    end interface


    interface initfields_stagg
        subroutine initfields_stagg(decompC, decompE, dx, dy, dz, inpDirectory, mesh, fieldsC, fieldsE, u_g, fcorr)
            import :: rkind
            import :: decomp_info
            type(decomp_info), intent(in) :: decompC
            type(decomp_info), intent(in) :: decompE
            real(rkind), intent(inout) :: dx, dy, dz
            character(len=*), intent(in) :: inpDirectory
            real(rkind), dimension(:,:,:,:), intent(in) :: mesh
            real(rkind), dimension(:,:,:,:), intent(inout) :: fieldsC
            real(rkind), dimension(:,:,:,:), intent(inout) :: fieldsE
            real(rkind), intent(out) :: u_g, fcorr

        end subroutine 
    end interface

    interface hook_output
        subroutine hook_output(decomp,der,fil,dx,dy,dz,outputdir,mesh,fields,tsim,vizcount,x_bc,y_bc,z_bc)
            import :: rkind
            import :: decomp_info
            import :: derivatives
            import :: filters
            type(decomp_info),               intent(in) :: decomp
            type(derivatives),               intent(in) :: der
            type(filters),                   intent(in) :: fil
            real(rkind),                     intent(in) :: dx,dy,dz,tsim
            character(len=*),                intent(in) :: outputdir
            real(rkind), dimension(:,:,:,:), intent(in) :: mesh
            real(rkind), dimension(:,:,:,:), intent(in) :: fields
            integer,                         intent(in) :: vizcount
            integer, dimension(2),       intent(in) :: x_bc, y_bc, z_bc

        end subroutine
    end interface

    interface hook_bc
        subroutine hook_bc(decomp,mesh,fields,tsim,x_bc,y_bc,z_bc)
            import :: rkind
            import :: decomp_info
            type(decomp_info),               intent(in)    :: decomp
            real(rkind),                     intent(in)    :: tsim
            real(rkind), dimension(:,:,:,:), intent(in)    :: mesh
            real(rkind), dimension(:,:,:,:), intent(inout) :: fields
            integer, dimension(2),       intent(in)    :: x_bc, y_bc, z_bc

        end subroutine
    end interface


    interface hook_timestep
        subroutine hook_timestep(decomp,der,mesh,fields,step,tsim,dt,x_bc,y_bc,z_bc,hookcond)
            import :: rkind
            import :: decomp_info
            import :: derivatives
            type(decomp_info),               intent(in)    :: decomp
            type(derivatives),               intent(in)    :: der
            integer,                         intent(in)    :: step
            real(rkind),                     intent(in)    :: tsim
            real(rkind),                     intent(in)    :: dt
            real(rkind), dimension(:,:,:,:), intent(in)    :: mesh
            real(rkind), dimension(:,:,:,:), intent(in)    :: fields
            integer,     dimension(2),       intent(in)    :: x_bc, y_bc, z_bc
            logical,               optional, intent(inout) :: hookcond

        end subroutine
    end interface

    interface hook_source
        subroutine hook_source(decomp,mesh,fields,tsim,rhs,rhsg)
            import :: rkind
            import :: decomp_info
            type(decomp_info),               intent(in)    :: decomp
            real(rkind),                     intent(in)    :: tsim
            real(rkind), dimension(:,:,:,:), intent(in)    :: mesh
            real(rkind), dimension(:,:,:,:), intent(in)    :: fields
            real(rkind), dimension(:,:,:,:), intent(inout) :: rhs
            real(rkind), dimension(:,:,:,:), optional, intent(inout) ::rhsg

        end subroutine
    end interface

    interface hook_finalize
        subroutine hook_finalize()
        end subroutine
    end interface

end module 
